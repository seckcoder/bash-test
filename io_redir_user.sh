#!/bin/bash

test1() {
    echo -e "[j] <> filename \n\tOpen file 'filename' for r and w and assign file\
        descriptor 'j' to it"
    echo 1234567890 > data/io_redirection_user
    exec 3<> data/io_redirection_user # Open 'File' and assign fd 3 to it
    read -n 4 <&3  # Read 4 characters from fd 3
    echo -n . >&3  # Write '.' to fd 3
    exec 3>&-  # Close fd 3 for stdout(write)
    exec 3<&-  # Close fd 3 for stdint(read)
    cat data/io_redirection_user
}
test2() {
    cat /etc/passwd | awk -F: '{ print $1 }' | sort 1>data/io_redirection_user 2>&1
    cat data/io_redirection_user
}
test3() {
    echo "fd 0(stdin), fd 1(stdout), fd 2(stderr), if one of those\
        three fds' not open, you may encounter problem"
    cat /etc/passwd >&-  # Close stdout
}
#test1
#test2
