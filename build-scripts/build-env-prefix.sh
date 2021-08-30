set -e

#===============================
# This scripts is use to generate the image tag prefix
# based on the environment we are targeting.
#
# Only the prod environment should not contains any prefix
#

case "$ENV_TARGET" in
    dev | DEV | Dev)
        echo "dev-"
        ;;
    prod | PROD | Prod)
        echo ""
        ;;
    *)
        return 1;
esac