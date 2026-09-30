#!/bin/bash

echo " Cybersecurity Level 1 Project"

echo "1. Symmetric Encryption"
echo "2. Symmetric Decryption"
echo "3. Generate Keys"
echo "4. Asymmetric Encryption"
echo "5. Asymmetric Decryption"
echo "6. Hash File"
echo "7. Digitally Sign File"
echo "8. Verify Signature"
echo "9. Exit"

read -p "Select an option: " choice

case $choice in

    1)
    echo "Symmetric Encryption selected"

    read -p "Enter file to encrypt: " filename

    openssl enc -aes-256-cbc -pbkdf2 -iter 1000 \
    -in "$filename" \
    -out "$filename.enc"

    echo "File encrypted successfully"
    ;;

2)
    echo "Symmetric Decryption selected"

    read -p "Enter encrypted file: " filename

    openssl enc -d -aes-256-cbc -pbkdf2 -iter 1000 \
    -in "$filename" \
    -out "$filename.dec"

    echo "File decrypted successfully"
    ;;
 3)
    echo "Generate Keys selected"

    openssl genrsa -out private.pem 2048
    openssl rsa -in private.pem -pubout -out public.pem

    echo "Keys generated successfully"
    ;;

4)
    echo "Public Key Encryption selected"

    read -p "Enter file name: " inputfile

    openssl pkeyutl \
    -encrypt \
    -pubin \
    -inkey public.pem \
    -in "$inputfile" \
    -out "$inputfile.encrypted"

    echo "Encryption completed"
    ;;

5)
    echo "Private Key Decryption selected"

    read -p "Enter encrypted file: " inputfile

    openssl pkeyutl \
    -decrypt \
    -inkey private.pem \
    -in "$inputfile" \
    -out "$inputfile.decrypted"

    echo "Decryption completed"
    ;;

6)
    echo "File Hashing selected"

    read -p "Enter file name: " inputfile

    openssl dgst -sha256 "$inputfile"

    echo "Hash calculation complete"
    ;;

7)
    echo "Digital Signature selected"

    read -p "Enter file name: " inputfile

    openssl dgst -sha256 \
    -sign private.pem \
    -out "$inputfile.signature" \
    "$inputfile"

    echo "Digital signature created"
    ;;

8)
    echo "Signature Verification selected"

    read -p "Enter original file: " inputfile
    read -p "Enter signature: " signaturefile

    openssl dgst -sha256 \
    -verify public.pem \
    -signature "$signaturefile" \
    "$inputfile"

    ;;

9)
    echo "Exiting..."
    exit
    ;;

*)
    echo "Invalid option"
    ;;

esac
