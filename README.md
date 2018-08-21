# SFRollingView
类似头条滚动显示，可任意编辑滚动方向前后左右

1、使用方式：

		YJRollingView *view = [[YJRollingView alloc]initWithFrame:CGRectMake(20, 100, 200, 30)];

		view.backgroundColor = [UIColor yellowColor];

		view.titleArray = @[@"ONE",@"TWO"];

		view.rollingDirection = YJRollingDirectionVerticalTop;

		[self.view addSubview:view];


2、如果需要设置为滚动方式，只需要加上下列代码：

		[view startRolling];


3、如果需要设置为滚动时间，只需要在2步之前加入代码：

		// rollingDuration：用于设置滚动时所需要的时间 

		// standbyDuration：用于设置停止滚动时静态显示时间

		view.rollingDuration = 1.0f;

		view.standbyDuration = 3.0f;
