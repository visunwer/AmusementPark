// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Подготовить архив.
// 
// Возвращаемое значение:
//  Строка - Подготовить архив
Функция ПодготовитьАрхив() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПРЕДСТАВЛЕНИЕ(УНИКАЛЬНЫЙИДЕНТИФИКАТОР(Аттракционы.Ссылка)) КАК Идентификатор,
		|	ПРЕДСТАВЛЕНИЕ(Аттракционы.Ссылка) КАК Аттракцион,
		|	ПРЕДСТАВЛЕНИЕ(Аттракционы.ВидАттракциона) КАК ВидАттракциона,
		|	ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Цена, 0) КАК Цена,
		|	Аттракционы.Фото
		|ИЗ
		|	Справочник.Аттракционы КАК Аттракционы
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних КАК ЦеныНоменклатурыСрезПоследних
		|		ПО Аттракционы.Ссылка = ЦеныНоменклатурыСрезПоследних.Номенклатура";
		
	Выборка = Запрос.Выполнить().Выбрать();
	
	ИмяКаталога = ПолучитьИмяВременногоФайла("");
	СоздатьКаталог(ИмяКаталога);
	
	ОписанияАттракционов = Новый Массив;
	
	ШаблонИмениКартинки = "%1%2img%2%3.jpg";
		
	Пока Выборка.Следующий() Цикл
		
		ОписаниеАттракциона = Новый Структура;
		ОписаниеАттракциона.Вставить("Идентификатор", Выборка.Идентификатор);
		ОписаниеАттракциона.Вставить("Аттракцион", Выборка.Аттракцион);
		ОписаниеАттракциона.Вставить("ВидАттракциона", Выборка.ВидАттракциона);
		ОписаниеАттракциона.Вставить("Цена", Выборка.Цена);
		
		ДанныеФото = Выборка.Фото.Получить();
		
		Если ДанныеФото = Неопределено Тогда
			ОписаниеАттракциона.Вставить("Фото", Неопределено);
		Иначе
			ИмяФайла = СтрШаблон(ШаблонИмениКартинки, ИмяКаталога, ПолучитьРазделительПути(), Выборка.Идентификатор);
			ДанныеФото.Записать(ИмяФайла);
			ОписаниеАттракциона.Вставить("Фото", 
				СтрШаблон(ШаблонИмениКартинки, "", ПолучитьРазделительПути(), Выборка.Идентификатор));
		КонецЕсли;
		
		ОписанияАттракционов.Добавить(ОписаниеАттракциона);
				
	КонецЦикла;
	
	ШаблонИмениФайлаВыгрузки = "%1%2export.json";
	ИмяФайлВыгрузки = СтрШаблон(ШаблонИмениФайлаВыгрузки, ИмяКаталога, ПолучитьРазделительПути());
	
	Запись = Новый ЗаписьJSON;
	Запись.ОткрытьФайл(ИмяФайлВыгрузки);
	ЗаписатьJSON(Запись, ОписанияАттракционов);
	Запись.Закрыть();
	
	Архиватор = Новый ЗаписьZipФайла;
	Архиватор.Добавить(ИмяКаталога + ПолучитьРазделительПути() + "*.*",, 
		РежимОбработкиПодкаталоговZIP.ОбрабатыватьРекурсивно);
	ДанныеАрхива = Архиватор.ПолучитьДвоичныеДанные();
		
	УдалитьФайлы(ИмяКаталога);
	
	Возврат ПоместитьВоВременноеХранилище(ДанныеАрхива); 
	
КонецФункции

#КонецОбласти

#КонецЕсли
