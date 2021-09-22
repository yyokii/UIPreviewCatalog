#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Set the target name as an argument."
  exit 1
fi

${BUILD_DIR%Build/*}SourcePackages/checkouts/UIPreviewCatalog/Tools/CodeGenerator/Sourcery/sourcery \
   --sources $SCRIPT_INPUT_FILE_0 \
   --templates ${BUILD_DIR%Build/*}SourcePackages/checkouts/UIPreviewCatalog/Tools/CodeGenerator/Templates \
   --output $SCRIPT_OUTPUT_FILE_0 \
   --args mainTarget=$1
