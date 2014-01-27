#!/bin/sh

PY_VERSIONS="2.6 2.7 3.3"

tmpdir=`mktemp -d`
cd $tmpdir

for py_version in $PY_VERSIONS ; do
    virtualenv --python=python$py_version venv_$py_version
    cd venv_$py_version
    source bin/activate
    pip install wheel
    pip wheel lxml
    pip wheel pillow
    # upload to our server
    # scp wheelhouse/*.whl getnikola.com:/nikola/wheels/
    deactivate
    cd ..
done


# clean up 
cd ..
rm -rf $tmpdir
