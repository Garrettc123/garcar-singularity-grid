#!/bin/bash
set -e
echo "Loading master secrets into Singularity Grid..."
while IFS='=' read -r key value; do
    [ -z "$key" ] || [[ "$key" == #* ]] && continue
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")
    if [ -n "$value" ]; then
        echo "$value" | gh secret set "$key" --repo "Garrettc123/garcar-singularity-grid"
        echo "Successfully injected: $key"
    fi
done < .vault.env
