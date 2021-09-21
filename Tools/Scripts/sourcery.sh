#!/bin/sh

${BUILD_DIR%Build/*}SourcePackages/checkouts/UIPreviewCatalog/Tools/CodeGenerator/Sourcery/sourcery \
   --sources $SCRIPT_INPUT_FILE_0 \
   --templates ../CodeGenerator/Templates/ \
   --output $SCRIPT_OUTPUT_FILE_0 \
