# Requirements
# 1. entrypoint.sh - So db2 starts when container is run
# 2. db2.tar - These are the database scripts from a create deployment environment where bpm.de.deferSchemaCreation=true
# 3. Dockerfile

# To build
# docker build -t gmortel/db2express-c:database-created .

# To start db2 then run a bash shell
# docker run -it --name=DB2Server -p 50000:50000 -e DB2INST1_PASSWORD=Bpmr0cks -e LICENSE=accept gmortel/db2express-c:database-created -bash

# To just start db2
# docker run -d --name=DB2Server -p 50000:50000 -e DB2INST1_PASSWORD=Bpmr0cks -e LICENSE=accept gmortel/db2express-c:database-created

FROM ibmcom/db2express-c
MAINTAINER Gerard Mortel "gmortel@us.ibm.com / gerard.mortel@gmail.com"
ADD db2.tar /tmp/
RUN ["/bin/bash", "-c", "yum makecache fast && yum -y -q install unzip && su - db2inst1 -c '/home/db2inst1/sqllib/adm/db2start && cd /tmp/DB2/QBPMDB85 && ./createDatabase.sh && cd /tmp/DB2/QCMNDB85 && ./createDatabase.sh && cd /tmp/DB2/QPDWDB85 && ./createDatabase.sh'"]
ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22 50000

# +-----------------------------------------------+
# |     gmortel/db2express-c:database-created     |  <-- BPM Advanced 856 BPM db, CMN db and PDW db created (YOU ARE HERE)
# +-----------------------------------------------+
# |              ibmcom/db2express-c              |  <-- DB2 Express-C 10.5.0.5
# +-----------------------------------------------+


