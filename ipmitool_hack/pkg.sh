#!/bin/bash

set -e
set -x
set -v

USAGE="$0 <command>"
USAGE_build="$0 build <package>"

die() {
	echo "$@"
	exit 1
}

has() {
	local flag="$1" ; shift
	for f in "$@" ; do
		[[ "${f}" = "${flag}" ]] && return 0
	done
	return 1
}

verify() {
	while read type sum file ; do
		case "${type}" in
			AUX)
				echo "${sum}  ${AUXDIR}/${file}" | sha256sum -c
				;;
			SCRIPT)
				echo "${sum}  ${SCRIPTDIR}/${file}" | sha256sum -c
				;;
			SOURCE)
				if has "${file}" "${SOURCES[@]}" ; then
					echo "${sum}  ${SOURCEDIR}/${file}" | sha256sum -c
				fi
				;;
			*)
				die "Unknown manifest type '${type}'"
				;;
		esac
	done < "${SCRIPTDIR}"/Manifest
}

epatch() {
	for p in "${PATCHES[@]}" ; do
		local n f="${AUXDIR}/${p}"
		[ -f "${f}" ] || die "patch '${f}' not a file"
		patch -p2 < "${f}" && break
		[ $? -eq 0 ] || die "applying '$f' failed"
	done
}

pkg_install() {
	cp -a "${D}"/* "${ROOT}"
}

build() {
	[[ "$1" ]] || die "${USAGE_build}"
	P="$1" ; shift

	PN="${P%%-[0-9]*}"
	PV="${P##${PN}-}"

	SCRIPTFILE="${SCRIPTDIR}/${P}.build"

	source "${SCRIPTFILE}"

	src_fetch
	verify
	src_unpack
	src_prepare
	set -x
	src_configure
	src_compile
	src_install
	pkg_install
}

manifest() {
	local MANIFESTFILE="${SCRIPTDIR}"/Manifest

	sed -i "${MANIFESTFILE}" \
		-e '/^AUX  /d' \
		-e '/^SCRIPT  /d'

	cd "${SCRIPTDIR}"
	for f in *.build ; do
		sha256sum "${f}" | sed -e 's:^:SCRIPT  :' >> "${MANIFESTFILE}"
	done

	cd "${AUXDIR}"
	for f in * ; do
		sha256sum "${f}" | sed -e 's:^:AUX  :' >> "${MANIFESTFILE}"
	done
}

command() {
	[[ "$1" ]] || die "${USAGE}"
	local command="$1" ; shift

	case "${command}" in
		build) build "$@" ;;
		manifest) manifest "$@" ;;
	esac
}

MYDIR="$(cd $(dirname $0) && echo ${PWD})"
SCRIPTDIR="${MYDIR}/script"
AUXDIR="${SCRIPTDIR}/aux"

command "$@"
