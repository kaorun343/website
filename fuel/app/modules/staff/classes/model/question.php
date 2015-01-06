<?php

namespace Staff;

class Model_Question extends \Orm\Model
{
	protected static $_properties = array(
		'id',
		'lesson_id' => [
			'label' => '課題番号',
			'form' => ['type' => false,],
			'validation' => ['required'],
		],
		'type' => [
			'label' => '種類',
			'form' => [
				'type' => 'select',
				'options' => ['radio' => 'radio'],
			],
			'default' => "radio",
			'validation' => ['required'],
		],
		'sentence' => [
			'label' => '問題文',
			'form' => [
				'type' => 'text',
			],
			'validation' => ['required'],
		],
		'choices' => [
			'data_type' => 'serialize',
			'label' => '選択肢',
			'form' => ['type' => false,],
			'validation' => ['required'],
		],
		'answer' => [
			'data_type' => 'tinyint',
			'label' => '正答',
			'form' => ['type' => false,],
			'validation' => ['required'],
		],
		'created_at' => [
			'form' => ['type' => false,],
		],
		'updated_at' => [
			'form' => ['type' => false,],
		],
	);

	protected static $_observers = array(
		'Orm\Observer_CreatedAt' => array(
			'events' => array('before_insert'),
			'mysql_timestamp' => false,
		),
		'Orm\Observer_UpdatedAt' => array(
			'events' => array('before_update'),
			'mysql_timestamp' => false,
		),
		'Orm\Observer_Self' => array(
			'events' => array('after_load'),
		),
		'Orm\Observer_Typing' => array(
			'events' => array('after_load', 'before_save', 'after_save')
		),
	);

	protected static $_table_name = 'questions';

	protected static $_belongs_to = ['lesson'];

	public function _event_after_load()
	{
		// JavaScriptで利用するためにプロパティを追加
		$this->model="";
	}

}
