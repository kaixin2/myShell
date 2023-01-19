#!/bin/bash
# about openssl enc command
# -help               Display this summary
# -list               List ciphers
# -ciphers            Alias for -list
# -in infile          Input file
# -out outfile        Output file
# -pass val           Passphrase source
# -e                  Encrypt
# -d                  Decrypt
# -p                  Print the iv/key
# -P                  Print the iv/key and exit
# -v                  Verbose output
# -nopad              Disable standard block padding
# -salt               Use salt in the KDF (default)
# -nosalt             Do not use salt in the KDF
# -debug              Print debug info
# -a                  Base64 encode/decode, depending on encryption flag
# -base64             Same as option -a
# -A                  Used with -[base64|a] to specify base64 buffer as a single line
# -bufsize val        Buffer size
# -k val              Passphrase
# -kfile infile       Read passphrase from file
# -K val              Raw key, in hex
# -none               Don't encrypt
# -*                  Any supported cipher
# -rand val           Load the file(s) into the random number generator
# -writerand outfile  Write random data to the specified file
# -z                  Use zlib as the 'encryption'
# -engine val         Use engine, possibly a hardware device

# ./hk3110.sh U2FsdGVkX1/INxBgSzpc5tWItX9vWn7/IehenKhU40U=

#Decryption method
IV="E27DCFC8DF33FA58E335BEBB5978B7B4"
function my_decrypt() {
    echo "$1" | openssl enc -d -aes-128-cbc -a -k $2 -iv $IV -iter 10 2> /dev/null
}
# Get the decrypted cipher text from the parameters of the execution script
encrypt_str=$1
declare -A map

#  Specify the dictionary file to be read path
FILE="./test.txt"
for key in $(cat $FILE)
do
  key=$(echo $key |tr -d '\n\r')
  map[$key]=1
done

# Brute force lookup of plaintexts and passwords
for key in $(cat $FILE)
do
  for((i=0;i<10;i++));
  do
    # When reading multiple rows of data, the newline at the end of the row is read, so it is processed
    key=$(echo $key |tr -d '\n\r\0')
    temp_key=$i$key
#    echo $temp_key
    decrypt_result=$(my_decrypt $encrypt_str $temp_key)
    if(( $? == 0))
    then
      # If the plaintext cannot be found in the associated array, it means that the password cannot help to decrypt
      # If there is the plaintext record in the associated array, the decryption is successful and the plaintext and password are printed.
      str=${map[$decrypt_result]}
      if [ ${#str} -eq 1 ];then
         echo "source_str: "$decrypt_result
         echo "source_key: "$temp_key
         exit 0
      fi
    fi
  done
done

# If it is not found, the ciphertext is wrong and cannot be encrypted by the word and ciphertext in the dictionary.
echo "wrong encrypt_str!"
exit 1

