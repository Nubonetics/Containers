#!/usr/bin/env bash
#
# Copyright 2017 - 2018 Ternaris
# SPDX-License-Identifier: Apache 2.0
#
# ref: https://gitlab.com/ApexAI/AutowareAuto/-/blob/master/tools/ade_image/env.sh

for x in /opt/*; do
    if [[ -e "$x/.env.sh" ]]; then
        source "$x/.env.sh"
    fi
done

cd
