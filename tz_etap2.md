# Этап 2. Наценка за некратность

## Заимствованная роль ПолныеПрава

Выгрузка `scripts\dump.cmd` в `_check`, код 0. В `TestZadanie` появился только `Roles\ПолныеПрава.xml`. `Ext\Rights.xml` нет: права ещё не расширены.

Формат, `Roles\ПолныеПрава.xml`:

- uuid расширения `f929311d-bc10-4ff7-a13c-614eaee5a9a5`.
- `InternalInfo`: `xr:PropertyState`, свойство `Rights`, состояние `Extended`.
- `Properties`: `ObjectBelonging` = `Adopted`, `Name` = `ПолныеПрава`, пустой `Comment`, `ExtendedConfigurationObject` `fdb012c9-583a-42af-95da-070e75a58078`.
- Узла `ChildObjects` нет (как у роли в `osn`: только `Properties`).

В `Configuration.xml` роль стоит в `ChildObjects` после собственных ролей: `тз_ИзменениеНаценкиЗаНекратность`, `тз_НастройкаНаценкиИУровней`, `тз_ОсновнаяРоль`, `ПолныеПрава`.

## Эталон внешней обработки

Файл `epf_src\тз_РасчетНаценкиЗаНекратность.xml`. Модуля и форм в выгрузке нет.

- Корень `ExternalDataProcessor`, uuid `f93f1c92-c475-49b2-8ada-4ba4defc971c`.
- `InternalInfo` / `xr:ContainedObject`: `ClassId` `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`, `ObjectId` `c383e3f5-a19a-4299-b006-27040a57bbef`.
- `GeneratedType` `ExternalDataProcessorObject.тз_РасчетНаценкиЗаНекратность`, category `Object`, `TypeId` `ec6ea296-311b-4dd0-9f5d-ef4e8b6b17f9`, `ValueId` `437908f0-dcfd-4880-b185-a59fa824c1a2`.
- `Properties`: `Name`, `Synonym` («Расчет наценки за некратность»), пустой `Comment`, пустые `DefaultForm` и `AuxiliaryForm`.
- Пустой `<ChildObjects/>`.

Модуль объекта кладётся рядом: `epf_src\тз_РасчетНаценкиЗаНекратность\Ext\ObjectModule.bsl`. Uuid эталона не меняются.