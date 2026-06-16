#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const root = process.cwd();
const questionDataDir = path.join(root, "Swift Quiz Academy", "QuestionData");
const difficulties = new Set(["beginner", "intermediate", "advanced"]);
const categories = new Map([
  ["swift-basics", "swift_basics.json"],
  ["swiftui", "swiftui.json"],
  ["ios-development", "ios_development.json"],
  ["programming-logic", "programming_logic.json"],
  ["ai-for-developers", "ai_for_developers.json"],
  ["git-github", "git_github.json"],
  ["architecture-mvvm", "architecture_mvvm.json"],
  ["xcode-debugging", "xcode_debugging.json"],
]);

function isNonEmptyString(value) {
  return typeof value === "string" && value.trim().length > 0;
}

function validateQuestion(question, expectedCategoryId, errors) {
  const label = question && question.id ? question.id : `${expectedCategoryId}:<missing-id>`;

  if (!isNonEmptyString(question.id)) {
    errors.push(`${label}: missing id`);
  }

  if (question.categoryId !== expectedCategoryId) {
    errors.push(`${label}: categoryId must be ${expectedCategoryId}, got ${question.categoryId}`);
  }

  if (!difficulties.has(question.difficulty)) {
    errors.push(`${label}: invalid difficulty ${question.difficulty}`);
  }

  for (const key of ["questionBG", "questionEN", "explanationBG", "explanationEN"]) {
    if (!isNonEmptyString(question[key])) {
      errors.push(`${label}: ${key} is missing or empty`);
    }
  }

  for (const key of ["answersBG", "answersEN"]) {
    if (!Array.isArray(question[key]) || question[key].length !== 4) {
      errors.push(`${label}: ${key} must contain exactly 4 answers`);
      continue;
    }

    const trimmed = question[key].map((answer) => typeof answer === "string" ? answer.trim() : "");
    if (trimmed.some((answer) => answer.length === 0)) {
      errors.push(`${label}: ${key} contains an empty answer`);
    }

    if (new Set(trimmed).size !== 4) {
      errors.push(`${label}: ${key} contains duplicate answers`);
    }
  }

  if (Array.isArray(question.answersBG) && !question.answersBG.includes(question.correctAnswerBG)) {
    errors.push(`${label}: correctAnswerBG is not present in answersBG`);
  }

  if (Array.isArray(question.answersEN) && !question.answersEN.includes(question.correctAnswerEN)) {
    errors.push(`${label}: correctAnswerEN is not present in answersEN`);
  }
}

function main() {
  const errors = [];
  const seenIDs = new Set();
  let totalQuestions = 0;

  for (const [categoryId, fileName] of categories) {
    const filePath = path.join(questionDataDir, fileName);

    if (!fs.existsSync(filePath)) {
      errors.push(`${categoryId}: missing file ${fileName}`);
      continue;
    }

    let questions;
    try {
      questions = JSON.parse(fs.readFileSync(filePath, "utf8"));
    } catch (error) {
      errors.push(`${fileName}: invalid JSON (${error.message})`);
      continue;
    }

    if (!Array.isArray(questions)) {
      errors.push(`${fileName}: root must be an array`);
      continue;
    }

    const counts = { beginner: 0, intermediate: 0, advanced: 0 };
    totalQuestions += questions.length;

    for (const question of questions) {
      if (question && isNonEmptyString(question.id)) {
        if (seenIDs.has(question.id)) {
          errors.push(`${question.id}: duplicate question id`);
        }
        seenIDs.add(question.id);
      }

      if (question && difficulties.has(question.difficulty)) {
        counts[question.difficulty] += 1;
      }

      validateQuestion(question || {}, categoryId, errors);
    }

    for (const difficulty of difficulties) {
      if (counts[difficulty] < 20) {
        errors.push(`${categoryId}: expected at least 20 ${difficulty} questions, got ${counts[difficulty]}`);
      }
    }
  }

  if (errors.length > 0) {
    console.error("Question database validation failed:");
    for (const error of errors) {
      console.error(`- ${error}`);
    }
    process.exit(1);
  }

  console.log(`Question database validation passed: ${totalQuestions} questions across ${categories.size} categories.`);
}

main();
