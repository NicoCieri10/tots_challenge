// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthUserAdapter extends TypeAdapter<AuthUser> {
  @override
  final int typeId = 0;

  @override
  AuthUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthUser(
      id: fields[0] as int?,
      firstname: fields[1] as String?,
      lastname: fields[2] as String?,
      email: fields[3] as String?,
      photo: fields[4] as String?,
      phone: fields[5] as String?,
      facebookId: fields[6] as dynamic,
      role: fields[7] as int?,
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
      status: fields[10] as int?,
      isNotification: fields[11] as int?,
      caption: fields[12] as dynamic,
      tokenType: fields[13] as String?,
      accessToken: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthUser obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.photo)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.facebookId)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.isNotification)
      ..writeByte(12)
      ..write(obj.caption)
      ..writeByte(13)
      ..write(obj.tokenType)
      ..writeByte(14)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
