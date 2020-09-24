# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)

class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'

#------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------
#------------------------ modelos oficiales -----------------------------------------------------------------

class CStates(models.Model):
    state_id = models.IntegerField(primary_key=True)
    state = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'c_states'


class ChatUsers(models.Model):
    user = models.ForeignKey('Users', models.DO_NOTHING)
    chat = models.ForeignKey('Chats', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'chat_users'


class Chats(models.Model):
    chat_id = models.IntegerField(primary_key=True)
    state = models.ForeignKey(CStates, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'chats'


class Messages(models.Model):
    message_id = models.IntegerField(primary_key=True)
    chat = models.ForeignKey(Chats, models.DO_NOTHING)
    user = models.ForeignKey('Users', models.DO_NOTHING)
    text = models.CharField(max_length=4000, blank=True, null=True)
    date_msj = models.DateTimeField(blank=True, null=True)
    url_file = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'messages'


class UFriends(models.Model):
    user = models.OneToOneField('Users', models.DO_NOTHING, db_column='user', primary_key=True)
    user_added = models.ForeignKey('Users', models.DO_NOTHING, db_column='user_added')

    class Meta:
        managed = False
        db_table = 'u_friends'
        unique_together = (('user', 'user_added'),)


class UStates(models.Model):
    user = models.ForeignKey('Users', models.DO_NOTHING)
    state = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'u_states'


class Users(models.Model):
    user_id = models.IntegerField(primary_key=True)
    email = models.CharField(max_length=120)
    name = models.CharField(max_length=50)
    password = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'users'
