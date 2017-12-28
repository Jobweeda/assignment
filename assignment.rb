
require 'json'
#ec2 instance 2X vanaf properties..

instances                  = 1

output_description         = "Public IP address of the newly created EC2 instance"

security_group_description = "Enable SSH via port 22"

instance_format            = "EC2Instance"

allow_ssh_from             = "0.0.0.0/0"

ip_type                    = "PublicIp"

output_value_result        = ({
                             "Fn::GetAtt": [
                               instance_format,
                               ip_type
                               ]
                             })

from_port                  = 22
to_port                    = 22

img_id                     = "ami-b97a12ce"

instance_type              = "t2.micro"

type_info_instance         = "AWS::EC2::Instance"

type_info_security         = "AWS::EC2::Securitygroup"

begin
#template version
  aws_template = {
    AWSTemplateFormatVersion: "2010-09-09"
    }
#output
    create_output_result = {
      Description: output_description
      }
      create_output = {
        PublicIP: create_output_result,
        Value: output_value_result
        }

#resources
create_resources_result = {
    Properties: {
      ImageId: img_id,
      InstanceType: instance_type
    }
  }
  create_resources_instance = {
    "#{instance_format}": create_resources_result,
    Type: type_info_instance
    }
    create_resources_props = {
      Resources: create_resources_instance
      }

#security
  create_instance_security_group_result = {
    GroupDescription: security_group_description
  }
    security_group_ingress = {
     Properties: create_instance_security_group_result,
     SecurityGroupIngress: [
       {
         CidrIp: allow_ssh_from,
         FromPort: from_port,
         IpProtocol: "tcp",
         ToPort: to_port
       }
     ]
      }
      instance_security_group = {
        InstanceSecurityGroup: security_group_ingress,
        Type: type_info_security
        }
end



instance_amount = instances
  if instance_amount == 1
     puts JSON.generate(aws_template)
     puts JSON.generate(instance_security_group)
     puts JSON.generate(create_output)
     puts JSON.generate(create_resources_props)
  else
    puts JSON.generate(aws_template)
    puts JSON.generate(instance_security_group)
    puts JSON.generate(create_output)
    puts JSON.generate(create_resources_props)
    puts JSON.generate(create_resources_props)
end
