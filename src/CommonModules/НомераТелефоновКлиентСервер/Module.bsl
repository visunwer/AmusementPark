
#Область ПрограммныйИнтерфейс

// Нормализованный номер телефона.
// 
// Параметры:
//  Телефон - Строка
// 
// Возвращаемое значение: 
// 	Строка
//  
Функция НормализованныйНомерТелефона(Телефон, ВызыватьИсключение = Ложь) Экспорт
	
	Цифры = "0123456789";
	
	ЦифрыТелефона = "";
	
	Для Сч = 1 По СтрДлина(Телефон) Цикл
		
		Символ = Сред(Телефон, Сч, 1);
		
		Если СтрНайти(Цифры, Символ) = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		ЦифрыТелефона = ЦифрыТелефона + Символ;
				
	КонецЦикла;
	
	Если СтрНачинаетсяС(ЦифрыТелефона, "8") Тогда
		ЦифрыТелефона = "7" + Сред(ЦифрыТелефона, 2);
	КонецЕсли;
	
	Ошибки = Новый Массив;
	
	Если НЕ СтрНачинаетсяС(ЦифрыТелефона, "7") Тогда
		Ошибки.Добавить("Первая цифра номера телефона должна быть 7 или 8");
	КонецЕсли;
	
	Если НЕ СтрДлина(ЦифрыТелефона) = 11 Тогда
		Ошибки.Добавить("Номер телефона должен содержать 11 цифр");
	КонецЕсли;
	
	Если Ошибки.Количество() > 0 Тогда
		Если ВызыватьИсключение Тогда
			ВызватьИсключение СтрСоединить(Ошибки, ";");
		Иначе
			Возврат "";
		КонецЕсли;
	КонецЕсли;
	
	Возврат ЦифрыТелефона;	
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
