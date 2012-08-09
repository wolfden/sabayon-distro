#!/bin/sh

# The purpose of this script is to delete old versions
# of the kde-l10n ebuilds.
#
# This script requires two preset parameters:
# DEL_VERSIONS:  The versions to be deleted.
# SURVIVOR_VERSION: A survivor version to be used
#                   for rebuilding the manifests

DEL_VERSIONS="4.8.3"
SURVIVOR_VERSION="4.9.0"

# Remove/Delete the old versions.
for one_del_ver in $DEL_VERSIONS; do
    if [ "$one_del_ver" = "$SURVIVOR_VERSION" ]; then
	    echo ""
	    echo "Skipping $one_del_ver. It is the version that has to be kept."
	    continue
    fi

    for X in `find -name kde-l10n-*${one_del_ver}*.ebuild`; do
	    echo ""
	    echo " ________ Removing ${X} ________"
	    rm "${X}"
    done
done

# Regenerate the manifests based on a survivor version
for X in `find -name kde-l10n-*${SURVIVOR_VERSION}*.ebuild`; do
	echo " ________ Re-manifesting ${X} ________"
	ebuild "${X}" manifest
done
