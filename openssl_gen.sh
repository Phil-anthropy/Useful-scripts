#!/bin/bash

md="sha1 sha224 sha256 sha3-224 sha3-256 sha3-384 sha3-512 sha384 sha512 sha512-224 sha512-256"
algo="aes-128-cbc aes-128-ecb aes-192-cbc aes-192-ecb aes-256-cbc aes-256-ecb" 
hash="md5sum sha1sum sha256sum"

function encryptdata() {
   for b in $hash; do
    for a in $algo; do 
     for i in $md; do
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{8}).*/\1 /' 
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{8}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{8}).*/\1 /'

        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{10}).*/\1 /' 
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{10}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{10}).*/\1 /'


        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{12}).*/\1 /' 
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} 2>/dev/null | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} -pbkdf2 | $b | sed -r 's/(.{12}).*/\1 /'
        echo -n ${args[1]} | openssl enc -salt ${args[$2]} -e -$a -a -md $i -pass pass:${args[2]} -iter 10000 | $b | sed -r 's/(.{12}).*/\1 /'
     done
    done 
   done
}


encryptdata
