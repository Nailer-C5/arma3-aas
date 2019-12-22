
_viewDist=-1;
waitUntil 
{
	sleep 1;
	_viewDist= Flag1 getvariable ['S3_params_VD',-1]; 
	(_viewDist!=-1)
};

setViewDistance _viewDist;
setObjectViewDistance (_viewDist * 0.75);

hintsilent format ["New Params> viewDist %1", _viewDist];
