curl -N -s http://localhost:8080/apis/sample.k8s.io/v1alpha1/namespaces/default/mydeployments?watch=true | \
while read -r event
do
  type=$(echo "$event"     | jq -r '.type')
  name=$(echo "$event"     | jq -r '.object.metadata.name')
  replicas=$(echo "$event" | jq -r '.object.spec.replicas')

  case $type in
    ADDED)
      echo "$name is added"
      echo "Create $replicas Pods"
      ;;
    MODIFIED)
      echo "$name is updated"
      echo "Update to $replicas Pods"
      ;;
    DELETED)
      echo "$name is deleted"
      echo "Delete all Pods"
      ;;
    *)
      ;;
  esac
done
