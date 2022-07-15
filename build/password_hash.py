#!/usr/bin/env python3

"""
Script leveraged to generate a SHA512 hashed password to be put into the topology yaml file.
"""

import crypt
import getpass

def main():
    while True:
        user_pass = getpass.getpass("Password: ")
        confirm_pass = getpass.getpass("Confirm Password: ")
        if user_pass == confirm_pass:
            print("Passwords match...")
            break
        else:
            print("Passwords do not match. Please re-enter")

    mgmt_pass = crypt.crypt(user_pass, crypt.METHOD_SHA512)
    print(f"\nSHA512 Hash:\n{mgmt_pass}")

if __name__ == '__main__':
    main()
