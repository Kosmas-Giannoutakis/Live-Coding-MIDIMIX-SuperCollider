thisProcess.openUDPPort(12345);
thisProcess.openPorts;

OSCFunc.trace(true);
OSCFunc.trace(false);

(
var parameters=['emg/0','emg/1','emg/2','emg/3'];
var electrodeBus=4.collect({Bus.control(s)});

thisProcess.openUDPPort(12345);

parameters.do { |parameter, index|
	OSCdef.new(parameter,
		{
			arg msg, time, addr, port;
			electrodeBus[index].set(msg[1])
		},
		'/openbci/' ++ parameter).permanent_(true);
};


~lbe = {
	arg low=0, high=1, curve=\lin, lag=0.1;
	var stream, unmapedStream, mapedStream;

	unmapedStream = [0,1].asSpec.unmap(electrodeBus[0].kr.lag(lag));
	mapedStream=[low,high,curve].asSpec.map(unmapedStream);
	mapedStream;
};

~rbe = {
	arg low=0, high=1, curve=\lin, lag=0.1;
	var stream, unmapedStream, mapedStream;

	unmapedStream = [0,1].asSpec.unmap(electrodeBus[1].kr.lag(lag));
	mapedStream=[low,high,curve].asSpec.map(unmapedStream);
	mapedStream;
};

~lfe = {
	arg low=0, high=1, curve=\lin, lag=0.1;
	var stream, unmapedStream, mapedStream;

	unmapedStream = [0,1].asSpec.unmap(electrodeBus[2].kr.lag(lag));
	mapedStream=[low,high,curve].asSpec.map(unmapedStream);
	mapedStream;
};

~rfe = {
	arg low=0, high=1, curve=\lin, lag=0.1;
	var stream, unmapedStream, mapedStream;

	unmapedStream = [0,1].asSpec.unmap(electrodeBus[3].kr.lag(lag));
	mapedStream=[low,high,curve].asSpec.map(unmapedStream);
	mapedStream;
};

)

a = {Bus('control',109).kr.poll}.play
a.free