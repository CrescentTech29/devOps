#!/bin/bash

# Define the number of users to create and the password length
NUM_USERS=10
PASS_LENGTH=12

# Password file to store the generated passwords
PASSWORD_FILE="passwords.txt"

# Function to generate a random password
generate_password() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()-_=+' | fold -w $PASS_LENGTH | head -n 1
}

# Create a new user with a random password and store the password in the PASSWORD_FILE
create_user() {
	local username=$1
	local password=$(generate_password)

	useradd -m -s /bin/bash "$username"
	echo "$username:$password" | chpasswd

	echo "Created user: $username"
	echo "$username:$password" >> $PASSWORD_FILE
}

# Rotate the password for an existing user and store the new password in the PASSWORD_FILE
rotate_password() {
	local username=$1
	local password=$(generate_password)

	echo "$username:$password" | chpasswd

	echo "Rotated password for user: $username"
	echo "$username:$password" >> $PASSWORD_FILE
}

# Clean up the password file
rm -f $PASSWORD_FILE

# Loop through and create or rotate passwords for users
for i in $(seq 1 $NUM_USERS); do
	username="user$i"

	if id -u "$username" >/dev/null 2>&1; then
		# User exists, rotate the password
		rotate_password "$username"
	else
		# User does not exist, create the user with a random password
		create_user "$username"
	fi
done
