FROM amazonlinux:2
RUN yum install -y wget aws-cli unzip

COPY companies_house_to_s3.sh /companies_house_to_s3.sh

CMD ["./companies_house_to_s3.sh"]