#!/bin/bash

PROTOCOL_VERSION='3.0.0'


function process {
	FROM_PERUN="${WORK_DIR}/pbsmon_json"

	DST_DIR="/etc/pbsmon"
	DST_FILE="$DST_DIR/pbsmon_machines.json"


	### Status codes
	I_CHANGED=(0 "${DST_FILE} updated")
	I_NOT_CHANGED=(0 "${DST_FILE} has not changed")


	create_lock

	chmod 0644 "$FROM_PERUN"

	diff_mv_sync "${FROM_PERUN}" "${DST_FILE}"
	if [ $? -eq 0 ]; then
		log_msg I_CHANGED
		if [ -x "$DST_DIR/pbsmon_machines_changed.sh" ] ; then
			"$DST_DIR"/pbsmon_machines_changed.sh
		fi
	else
		log_msg I_NOT_CHANGED
	fi
}
