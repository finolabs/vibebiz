# Retail AI and automation patterns

A catalog of nine common patterns in retail. The solution-sketch lens uses it when it checks whether a rule, automation or AI fits an idea; the challenge lens uses it to test cost and risk.

## How to use

1. Match the user's idea to a pattern only after the problem and outcome are clear. A pattern never replaces the user's goal.
2. Read `fit` first. Many ideas that sound like AI are solved by a rule (a fixed threshold, a lookup) or by plain automation (a scheduled job, a template). Recommend the lowest level that meets the outcome, and say why.
3. `data_needed` is a checklist to ask the user about. Ask whether the data exists, where it lives, how clean it is and how far back it goes. Never assume it.
4. `rough_cost` is a size band only (small, medium, large). Always label it "not tech-reviewed" in anything the user sees, until the tech team has reviewed it. Do not turn a band into a money figure.
5. `risks` feed the cost-and-risk section and the question "who carries the cost of a wrong answer, and who approves before it reaches a customer".
6. `prior_art` describes generic, publicly known practice. It makes no performance claim; never quote vendor results. When the user asks for evidence, say what to measure in a small pilot instead.

## Fields

`name`, `data_needed`, `rough_cost` (small, medium or large; not tech-reviewed), `risks`, `prior_art`, `fit` (rule, automation or AI, with the deciding condition).

## Files

- `patterns.md`: the nine patterns.
