
Moonshot.config do |m|
  m.app_name = 'lap-tracker'
  m.environment_name = 'dev'
  m.artifact_repository = S3Bucket.new('lap-tracker')
  m.build_mechanism = Script.new('moonshot/bin/build.sh')
  m.deployment_mechanism = CodeDeploy.new(asg: 'AutoScalingGroup')
end
