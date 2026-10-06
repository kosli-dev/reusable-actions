# Slack rejects a section over 3000 characters and a header over 150.
def chunks($max):
  reduce (split("\n")[] | if length > $max then (. as $l | range(0; length; $max) | $l[.:. + $max]) else . end) as $line
    ([];
     if length > 0 and (.[-1] | length) + 1 + ($line | length) <= $max
     then .[-1] += "\n" + $line
     else . + [$line]
     end);

def color_of($c):
  {"success": "#2eb886", "failure": "#a30200", "cancelled": "#808080"}[$c] // $c;

([if $title != "" then {type: "header", text: {type: "plain_text", text: $title[:150]}} else empty end]
 + [$message | chunks(3000)[] | {type: "section", text: {type: "mrkdwn", text: .}}]
 + [if $footer != "" then {type: "context", elements: [{type: "mrkdwn", text: $footer}]} else empty end]
) as $blocks
| {text: ([$preview, $title, $message] | map(select(. != "")) | first)}
+ if $color != ""
  then {attachments: [{color: color_of($color), blocks: $blocks}]}
  else {blocks: $blocks}
  end
