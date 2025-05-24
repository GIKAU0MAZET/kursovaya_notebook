// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleEventAdapter extends TypeAdapter<ScheduleEvent> {
  @override
  final int typeId = 4;

  @override
  ScheduleEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleEvent(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      day: fields[3] as int,
      pairNumber: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleEvent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.pairNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
