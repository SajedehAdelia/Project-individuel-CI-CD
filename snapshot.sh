#!/bin/bash
# snapshot.sh
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
mkdir -p snapshots
tar -czf snapshots/envcast_snapshot_$timestamp.tar.gz ./Project-individuel-CI-CD
echo "Snapshot saved: snapshots/project_individuel_CI_CD_snapshot_$timestamp.tar.gz"
