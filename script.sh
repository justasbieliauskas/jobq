#!/usr/bin/env bash

JOBS_FILE=~/.jobs

function print_help() {
    cat << HELP

Job queue.

Usage:
    jobq push code-refactoring
    jobq pop
    jobq delete code-refactoring

HELP
}

function print_unknown_command() {
    echo "Unkown command - '$1'."
    echo 'Allowed commands are `--help`, `push`, `pop` and `delete`.'
}

function execute_push() {
    echo $1 >> $JOBS_FILE
    echo "Pushed item '$1'."
}

function execute_pop() {
    job=$(shuf $JOBS_FILE | head -n 1)
    echo "Do '$job'."
}

function execute_delete() {
    sed -i '' "/$1/ d" $JOBS_FILE
    echo "Deleted '$1'."
}

function command_name() {
    if [[ $# -eq 0 ]]; then echo '--help'; else echo $1; fi
}

function execute_command() {
    command=$(command_name "$@")
    case $command in
        '--help')
            print_help
        ;;
        'push' | 'pop' | 'delete')
            shift
            "execute_$command" "$@"
        ;;
        *)
            print_unknown_command "$command"
        ;;
    esac
}

execute_command "$@"
