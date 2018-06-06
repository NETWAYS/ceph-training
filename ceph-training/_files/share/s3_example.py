import boto
import boto.s3.connection

access_key = 'C2R939TLYZ2MUOMP1IS9'
secret_key = '5HQREJtoUS6vVNwaCZRgwEXqGiugeaLSJitKA4Sy'
hostname = 'radosgw-1.local'

conn = boto.connect_s3(
        aws_access_key_id = access_key,
        aws_secret_access_key = secret_key,
        host = hostname, port = 7480,
        is_secure=False, calling_format = boto.s3.connection.OrdinaryCallingFormat(),
        )


# Create a bucket
bucket = conn.create_bucket('my-bucket')
for bucket in conn.get_all_buckets():
  print "{name} {created}".format(name = bucket.name, created = bucket.creation_date,)

# get bucket and push/retrieve file
bucket = conn.get_bucket('my-bucket')
from boto.s3.key import Key
k = Key(bucket)

# myfile is the object name
k.key='myfile'
k.set_contents_from_filename('example.jpg')
k.get_contents_to_filename('still_a_example.jpg')

