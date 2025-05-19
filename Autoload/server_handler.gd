extends Node

# Main link for the http server (will be entered by user for initial handshake and http requests)
var link: String
# Room id player is connected to
var room_id: int
# Session token
var session_token: int
# Player name (gui lets player eventually pick their name)
var player_name: String
# List of nodes in a dictionary that all are to be synced. Each entry has a id, then object reference.
var sync_nodes: Dictionary
# Is http requester that handles sending out http requests (1 for now)
var requester: HTTPRequest = null : set = _set_http_requester
# Dictionary of responses, keys are the response string, with callables for response. This makes Dictionary
# data type the method to get responses from response types.
var response_list := {
	"cgs_auth_response_v1": server_handshake_response
}

# Sends actions in a packet to the http server
func send_actions(actions: String) -> void:
	if requester == null:
		printerr("No requester to send actions to.")
		return
	var actions_packet := {
		"cgs_format": "send actions format string (change when specific one decided)",
		"session_token": session_token,
		"actions": actions
	}
	var packet_str = JSON.stringify(actions_packet)
	requester.request(link, PackedStringArray(), 0, packet_str) # May change some perameters later
	
# Will decide what to do with data sent from http server response.
func decide_actions_from_response(data: Dictionary) -> void:
	if response_list.has(data.data_format):
		response_list[data.data_format].call(data)
	else:
		printerr("Unknown response format (%s)" % data.data_format)
	
func server_handshake_response(response: Dictionary) -> void:
	pass

# Will make sure when http requester is set, will connect the correct signal to it. Also will disconnect
# the same method from the old requester if applicable.
func _set_http_requester(value: HTTPRequest) -> void:
	if requester != null:
		requester.request_completed.disconnect(_http_request_completed)
	requester = value
	if requester != null:
		requester.request_completed.connect(_http_request_completed)
	
# Method called when http requester gets an answer from the server
func _http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json := JSON.new()
	json.parse(body.get_string_from_utf8()) # Assumes this is what to do to get data
	decide_actions_from_response(json.data)
