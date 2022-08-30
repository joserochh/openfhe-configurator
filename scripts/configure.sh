#!/bin/sh

. ./scripts/vars.sh
. ./scripts/functions.sh

OPENFHE_DEVELOPMENT_REPO="openfhe-development"
OPENFHE_REPO="openfhe-development"
INTEL_HEXL_HINT_DIR=""
LOCAL_HEXL_PREBUILT=""
OPENFHE_HEXL=""

ROOT=`pwd`

echo
echo "OpenFHE configurator"
echo

if [ -d ./openfhe-staging ]; then
  read -p "A previous staging directory exists, delete? [y/n] : " yn
  case $yn in
    [Nn]* ) echo; echo "Unwilling to proceed - aborting."; exit 1; break;;
  esac
  rm -rf ./openfhe-staging
fi

read -p "Would you like an OpenFHE Release build?     [y/n] : " yn
case $yn in
  [Yy]* ) OPENFHE_REPO="openfhe-release"; break;;
esac

read -p "Would you like to enable HEXL?               [y/n] : " yn
case $yn in
  [Yy]* ) 
    OPENFHE_HEXL="openfhe-hexl"; 
    read -p "Do you have a local pre-built of HEXL?       [y/n] : " in_yn
    case $in_yn in
      [Yy]* )
        LOCAL_HEXL_PREBUILT="pre-built-hexl";
        read -p "Provide directory (Like: ~/dir/lib/cmake/hexl-1.2.5):" dir
        INTEL_HEXL_HINT_DIR=$dir
        break;;
    esac 
    break;;
esac

if [ "x$OPENFHE_HEXL" = "x" ]; then
  if [ "$OPENFHE_REPO" = "$OPENFHE_DEVELOPMENT_REPO" ]; then
    $ROOT/scripts/stage-openfhe-development.sh
  else
    echo "Unsupported build type."
  fi
else
  LOCAL_HEXL_PREBUILT=$LOCAL_HEXL_PREBUILT INTEL_HEXL_HINT_DIR=$INTEL_HEXL_HINT_DIR $ROOT/scripts/stage-openfhe-development-hexl.sh
fi

