#!/bin/bash

# $1: template file name
# $2: cluster image name
# $3: target architecture (optional: amd64 or arm64)

echo "Building cluster image for $1"

template_file=$1
image_name=$2
target_arch=${3:-}

if [[ -z "$template_file" || -z "$image_name" ]]; then
  echo "Usage: $0 <template-file> <cluster-image-name>"
  exit 1
fi

if [[ $(basename "$template_file") == "index.yaml" || $(basename "$template_file") == "index.yml" ]]; then
  template_name=$(basename $(dirname "$template_file"))
else
  template_name=$(basename "$template_file")
  template_name=${template_name%.yaml}
  template_name=${template_name%.yml}
fi

if [[ ! -f "$template_file" ]]; then
  echo "Template file $template_file not found"
  exit 1
fi

template_dir=$(dirname "$template_file")

# prepare for build cluster image
rm -rf build
mkdir -p build/manifests build/registry build/images

cp "$template_file" build/manifests/template.yaml

images_file="$template_dir/images.txt"
if [[ -f "$images_file" ]]; then
  mkdir -p build/images/shim
  : > build/images/shim/images.txt

  while read -r image arches; do
    if [[ -z "$image" || "$image" == \#* ]]; then
      continue
    fi

    if [[ -z "$arches" || -z "$target_arch" || " $arches " == *" $target_arch "* || " $arches " == *" linux/$target_arch "* ]]; then
      echo "$image" >> build/images/shim/images.txt
    fi
  done < "$images_file"
fi

echo "
FROM scratch

USER 65532:65532

COPY registry registry
COPY manifests manifests
COPY images images
" > build/Kubefile

commitDATE=$(date +%Y%m%d%H%M%S)
repo_host=${GITHUB_SERVER_URL:-https://github.com}
repo_repo=${GITHUB_REPOSITORY:-labring-actions/templates}
repo_url="${repo_host%/}/${repo_repo}"
sealos build -f build/Kubefile -t "$image_name" \
    --label org.opencontainers.image.description="template cluster image" \
    --label org.opencontainers.image.licenses="Sealos Sustainable Use License" \
    --label org.opencontainers.image.source="${repo_url}" \
    --label org.opencontainers.image.title="templates-image" \
    --label org.opencontainers.image.time="${commitDATE}" \
    --label org.opencontainers.image.url="${repo_url}" \
    --label org.opencontainers.image.version="${template_name}"  build
