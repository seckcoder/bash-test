#!/bin/bash
# demo for copying and concatenating arrays



# Complex demo
function copy_array ()
{
    echo -n 'eval '
    echo -n "$2"
    echo -n '=( ${'
    echo -n "$1"
    echo -n '[@]})'
}

declare -f copy_array_fun
copy_array_fun=copy_array   # function pointer
function hype ()
{
    local -a TMP
    local -a hype=( Really Rocks )
    $($copy_array_fun $1 TMP)   # copy $1 to TMP
    TMP=( ${TMP[@]} ${hype[@]} )   # concat tmp and hype
    $($copy_array_fun TMP $2)   # copy tmp to $2
}

declare -a before=( Advanced Bash Scripting )
declare -a after

echo "Array Before = ${before[@]}"

hype before after

echo "Array After = ${after[@]}"


# Simple demo
ARR1=( I am )
ARR2=( seckcoder . I am a hacker )
RES=( ${ARR1[@]} ${ARR2[@]} )
echo ${RES[@]}
