#!/usr/bin/python3

import dodo
from sys import platform

from scripts.builder import process_tasks
from scripts import config
from scripts import version
from scripts import tests

if platform == 'msys':
	process_tasks(dodo.make_libxmlbird('libxmlbird.dll'))
elif platform == 'darwin':
	lib = "libxmlbird-" + str(version.LIBXMLBIRD_SO_VERSION_MAJOR) + '.dylib'
	process_tasks(dodo.make_libxmlbird(lib))
elif "openbsd" in platform:
	process_tasks(dodo.make_libxmlbird('libxmlbird.so.${LIBxmlbird_VERSION}'))
else:
	process_tasks(dodo.make_libxmlbird('libxmlbird.so.' + version.LIBXMLBIRD_SO_VERSION))
	tests.build_tests();

dodo.make_libxmlbird_pkgconfig ()

print('Done')
