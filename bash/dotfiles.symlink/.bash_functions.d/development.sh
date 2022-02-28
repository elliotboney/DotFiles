function envswitch() {
    if [ ! "$1" ]
    then
        echo "Missing required parameter envname"
        echo "File should exist in current directory as .env.envname"
        echo "Usage:"
        echo "  envswitch envname"
        return
    fi
 
    ENV_PATH="./.env"
    ENV_LINK=".env.$1"
 
    # Ensure the file being sylinked exists
    if [ ! -e "$ENV_LINK" ]
    then
        echo "Error: "$ENV_LINK" does not exist in current directory"
        return
    fi
 
    # If the ENV_PATH already exists, remove it
    if [ -e "$ENV_PATH" ]
    then
        rm -f "$ENV_PATH"
    fi
 
    # Symlink the file to $ENV_LINK
    ln -s "$ENV_LINK" "$ENV_PATH"
}