VERSION="v0.1.0"


function display_manual {
    echo "internsctl(1)                  User Commands                 internsctl(1)"
    echo ""
    echo "NAME"
    echo "       internsctl - Custom Linux command for operations"
    echo ""
    echo "SYNOPSIS"
    echo "       internsctl [OPTION]..."
    echo ""
    echo "DESCRIPTION"
    echo "       internsctl is a custom Linux command designed to perform various operations."
    echo ""
    echo "OPTIONS"
    echo "       -h, --help"
    echo "              Display this help message."
    echo ""
    echo "       -v, --version"
    echo "              Display the version of internsctl."
    echo ""
    echo "       -op, --operation OPERATION"
    echo "              Specify the operation to be performed."
    echo ""
    echo "EXAMPLES"
    echo "       internsctl --operation operation1"
    echo "              Perform Operation 1."
    echo ""
    echo "       internsctl --operation operation2"
    echo "              Perform Operation 2."
    echo ""
    echo "AUTHOR"
    echo "       Your Name"
}


function display_help {
    echo "Usage: internsctl [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help       Display this help message"
    echo "  -v, --version    Display the version of internsctl"
    echo "  -op, --operation Specify the operation to be performed"
}
function perform_operation {
    case "$1" in
        # ... (unchanged)
        "user")
            shift
            user_operations "$@"
            ;;
        *)
            echo "Invalid operation. Use -h or --help for usage information."
            exit 1
            ;;
    esac
}

function user_operations {
    local subcommand="$1"
    shift
    case "$subcommand" in
        "create")
            create_user "$@"
            ;;
        "list")
            list_users "$@"
            ;;
        *)
            echo "Invalid user operation. Use -h or --help for usage information."
            exit 1
            ;;
    esac
}


function create_user {
    local username="$1"
   
    if [ -z "$username" ]; then
        echo "Usage: internsctl user create <username>"
        exit 1
    fi

    useradd -m "$username"
    echo "User $username created successfully."
}

function list_users {
    if [ "$1" == "--sudo-only" ]; then
        # List users with sudo permissions
        getent group sudo | cut -d: -f4 | tr ',' '\n'
    else
   
        getent passwd | cut -d: -f1
    fi
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    
        -op|--operation)
            OPERATION="$2"
            perform_operation "$OPERATION"
            exit 0
            ;;
        *)
            echo "Invalid argument. Use -h or --help for usage information."
            exit 1
            ;;
    esac
    shift
done

display_manual