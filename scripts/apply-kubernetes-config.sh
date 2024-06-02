# Remove the older artifcat
rm -f /tmp/latest_artifact.zip
rm -rf /tmp/latest_artifact

# List all objects in the S3 bucket with the specified prefix
latest_artifact=$(aws s3 ls s3://codepipeline-us-east-1-411495364561/openglot-web-pipelin/BuildArtif/ --recursive | sort | tail -n 1 | awk '{print $4}')

# Download the latest artifact from S3
aws s3 cp s3://codepipeline-us-east-1-411495364561/$latest_artifact /tmp/latest_artifact.zip

# Unzip the latest artifact
unzip /tmp/latest_artifact.zip -d /tmp/latest_artifact

kubectl apply -f /tmp/latest_artifact/k8s/ --namespace openglot
