<!DOCTYPE html><?php $page = "Members Web" ?>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
    <meta name="_base" content="<?= Uri::base()?>">
    <title><?php echo $page; ?></title>
  </head>
  <body><?php $auth = Auth::check(); ?>
    <nav role="navigation" class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header"><?php echo Html::anchor('staff', $page, ['class' => 'navbar-brand']); ?></div>
        <ul class="nav navbar-nav"><?php if($auth): ?>
          <li><?php echo Html::anchor('staff', 'スタッフサイト'); ?></li>
          <li><?php echo Html::anchor('admin', '管理画面'); ?></li><?php endif; ?>
        </ul><?php if($auth): ?>
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown"><a href="#" data-toggle="dropdown" role="button" aria-expand="false" class="dropdown-toggle"><?php $f = Auth::get_profile_fields(); ?><?php echo $f['firstname']." ".$f['lastname']; ?><span class="caret"></span></a>
            <ul role="menu" class="dropdown-menu">
              <li><?php echo Html::anchor('user/logout', 'ログアウト'); ?></li>
            </ul>
          </li>
        </ul><?php endif; ?>
      </div>
    </nav>
    <div class="container">
      <h1 class="page-header">ユーザー情報</h1>
      <form method="POST">
        <legend>パスワード設定</legend><?php echo Form::csrf(); ?>
        <div class="form-group">
          <label for="old_password">現在のパスワード</label>
          <input type="text" name="old_password" required class="form-control">
        </div>
        <div class="form-group">
          <label for="password">新しいパスワード</label>
          <input type="password" name="password" required class="form-control">
        </div>
        <button type="submit" class="btn btn-default">変更</button>
      </form>
    </div>
    <footer>
      <p class="text-center">Copyright (c) 2015 PCMasters</p>
    </footer>
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script><?php echo Security::js_fetch_token(); ?>
  </body>
</html>