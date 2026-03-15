extends Node

var available_streams : int;
var streams : Array[AudioStreamPlayer];

func _ready() -> void:
	available_streams = 10;
	for i in range(available_streams):
		var stream = AudioStreamPlayer.new();
		stream.finished.connect(stream_playback_callback);
		add_child(stream);
		streams.append(stream);

func loan_stream(audio_file : AudioStream) -> bool:
	assert(streams.size() > 0); ## Must have streams to loan
	if (available_streams <= 0): return false;
	
	available_streams -= 1;
	var stream = streams.pop_front();
	streams.push_back(stream);
	
	stream.stream = audio_file;
	stream.play();
	
	print("Sanity Check Streams Count: %s" % streams.size());
	return true;

func stream_playback_callback() -> void:
	available_streams += 1;
	print("Stream ended and returned");
	print("Sanity Check Streams Count: %s" % streams.size());
