#!/bin/sh

script_dir=$(dirname "$(readlink -f "$0")")
cd $script_dir

config=dunstrc
theme=themes/frappe.conf
#theme=themes/latte.conf
#theme=themes/macchiato.conf
#theme=themes/mocha.conf
cat $config $theme
