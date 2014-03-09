	cp $pkgdir/build $top/.cache/$target

pkgdir=

fetch-target:
	cd src
	pkg=`echo $target | sed -e 's,-fetch$,,'`
	eval url=$url
	if test "$url" = ""; then
		if test "$git" != ""; then
			[ -d $pkg ] || git clone $git $pkg
		fi
	else
		wget -c $url
		file=`basename $url`
		type=`file -b $file | cut -d ' ' -f 1`
		case "$type" in
		gzip)
			tar -xzf $file
			;;
		bzip2)
			tar -xjf $file
			;;
		XZ)
			tar -xJf $file
			;;
		*)
			echo "Unknown file type $type" 1>&2
			exit 1
			;;
		esac
	fi
	cp $pkgdir/build $top/.cache/$target
