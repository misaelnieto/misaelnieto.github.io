Windoze cluster and linux iSCSI
===============================



.. author:: default
.. categories:: Gnome
.. tags:: none
.. comments::


I'm learning some windoze skills, and I had the opportunity to play with some
virtual machines in order to test an `Always On Availability group <http://blogs.msdn.com/b/srinivas-v-v/archive/2013/06/25/setting-up-always-on-
availability-group-on-sql-server-2012.aspx>`_ for SQL Server.

As far as I can understand, I cannot do any SQL Server configuration without
pairing the two window server nodes and configuring both nodes to a SAN so the
cluster provides some failover technobabble. And the *easiest* way I could
come up with was to install one linux VM and configure it as that iSCSI thing
and be done.
