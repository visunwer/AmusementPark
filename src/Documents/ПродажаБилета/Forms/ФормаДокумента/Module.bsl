
#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СкидкаПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура СуммаДокументаПриИзменении(Элемент)
	Объект.БаллыКСписанию = Объект.ПозицииПродажи.Итог("Сумма") - Объект.СуммаДокумента;
КонецПроцедуры
#КонецОбласти
#Область ОбработчикиСобытийЭлементовТаблицыФормыПозицииПродажи

&НаКлиенте
Процедура ПозицииПродажиНоменклатураПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ПозицииПродажи.ТекущиеДанные;
	
	ТекущиеДанные.Цена = ЦенаНоменклатуры(ТекущиеДанные.Номенклатура, Объект.Дата);

КонецПроцедуры

&НаКлиенте
Процедура ПозицииПродажиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ПозицииПродажи.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ПозицииПродажиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ПозицииПродажи.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ПозицииПродажиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.ПозицииПродажи.Итог("Сумма") - Объект.БаллыКСписанию;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ДанныеСтроки)
	
	ДанныеСтроки.Сумма = ДанныеСтроки.Цена * ДанныеСтроки.Количество;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЦенаНоменклатуры(Знач Номенклатура, Знач Период)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЦеныНоменклатурыСрезПоследних.Цена
		|ИЗ
		|	РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Период, Номенклатура = &Номенклатура) КАК
		|		ЦеныНоменклатурыСрезПоследних";
	
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Цена;
	КонецЕсли;
	
	Возврат 0;
		
КонецФункции

#КонецОбласти
