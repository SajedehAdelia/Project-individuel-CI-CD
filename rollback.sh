#!/bin/bash
# rollback.sh
echo "Available tags:"
git tag

read -p "Enter the tag to roll back to: " tag
git checkout $tag
echo "Rolled back to tag: $tag"
