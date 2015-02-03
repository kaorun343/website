<?php
return array(
	'_root_'  => 'staff/index',
	'staff/admin/lesson/(:num)' => 'staff/admin/lesson/index/$1',

	'staff/admin/lesson/(:num)/question' => 'staff/admin/question/index/$1',
	'staff/admin/lesson/(:num)/question/(:num)' => 'staff/admin/question/index/$1/$2',

	'staff/admin/lesson/(:num)/file' => 'staff/admin/file/index/$1',
	'staff/admin/lesson/(:num)/file/(:num)' => 'staff/admin/file/index/$1/$2',

	'staff/admin/download/(:num)' => 'staff/admin/download/index/$1',

	'staff/api/lesson/(:num)/questions' => 'staff/api/questions/$1',
	'staff/api/lesson/(:num)/result' => 'staff/api/result/$1',
	'staff/download' => 'staff/staff/download',
);
