// ignore_for_file: constant_identifier_names
const String GRAPHQL_LINK = "https://flexible-weevil-94.hasura.app/v1/graphql";
const String HASURA_PASSWORD =
    "4VXSAFspYjXb03dYm276UGq1DKO5IiKCW21NCWfyatYV98n8InfgxcZzTDUAdLMp";
const String FOK_KOMETA_MAP_URL = "https://goo.gl/maps/ZpJ4QfqU8UJB2GsA7";

const String SUPABASE_LINK = "";
const String SUPABASE_ANONKEY = "";

const String DESCRIPTION_OF_GROUP_TRAINING = '''

ПИЛАТЕС - уникальный комплекс упражнений, направленный в основном на укрепление мышц спины и живота, на проработку поверхностных и глубоких мышц туловища, формирование красивой осанки, улучшение гибкости и подвижности позвоночника.
Данный урок способствует комплексному оздоровлению организма.

ЙОГА - совокупность физических, психических и духовных практик, направленных на совершенствование человека. Включает в себя выполнение дыхательных практик и асан, каждая из которых имеет свой терапевтический эффект, имеющий целью восстановление и оздоровление всех систем жизнедеятельности организма. 'Йога 1 — занятие для начинающих. Йога 2 — занятие для подготовленных.

STRETCH - занятие, направленное на расслабление всех мышц тела, восстановление после физических нагрузок, снятие
напряжения, на улучшение всех обменных процессов в организме, а также на снятие эмоционального напряжения, на избавление от всех негативных мыслей, волнения, тревог и суеты.

ВОСТОЧНЫЕ ТАНЦЫ - это вершина красоты и женственности! Регулярно посещая данное занятие, Вы быстро приведете себя в форму и гармонизируете внутреннее состояние, ваше тело станет более пластичным, гибким и грациозным.

STRIP-ПЛАСТИКА - занятие, направленное на развитие женственности, на придание телу красивых, гармоничных форм, на увеличение гибкости и пластичности. Стрип-пластика улучшит осанку, сделает походку более грациозной, скорректирует недостатки фигуры.

ЗДОРОВАЯ СПИНА - это лечебно-оздоровительное занятие, направленное на развитие мышц спинного корсета, оздоровление позвоночника, реабилитацию после травм и нейтрализацию вредного влияния сидячей работы и малоподвижного образа жизни

ЗДОРОВАЯ СПИНА&ШПАГАТ - занятие разделено на две части, первая его часть (30 мин.) направлена на укрепление и
проработку мышц спины, на формирование красивой осанки; вторая часть (30 мин.) состоит из упражнений на растяжение мышц ног, на раскрытие тазобедренных суставов (выполняются подводящие упражнения к шпагату).

ABS - тренировка, направленная на укрепление и глубокую проработку мышц брюшного пресса, а также спины.
графической связки и полчаса силовых

STEP&SCULPT - занятие разделено на две части: полчаса степа несложной хореографической связи и полчаса силовых упражнений на укрепление всех мышц туловища. Особое внимание уделяется бедрам, ягодицам и животу.

POWER BODY - силовая тренировка, направленная на укрепление и проработку всех мыши тела, на увеличение силы и выносливости, на придание Вашему телу красивых, рельефных форм.

SUPER-SCULPT - силовая тренировка на все группы мышц, за короткие сроки помогает подтянуть всё тело, придать тонус и упругость мышцам, избавиться от живота. Проводится с дополнительным оборудованием: мини-штанги, бодибары, гантели, эспандеры, фитнес-резинки.''';

String descriptionIMT = '''16 и менее — выраженный дефицит массы тела
16—18,5 — недостаточная (дефицит) масса тела
18,5—25 — норма
25—30 — избыточная масса тела (предожирение)
30—35 — ожирение первой степени
35—40 — ожирение второй степени
40 и более — ожирение третьей степени (морбидное)''';
String cardView = r'''query cardView {
  card {
    card_category_id
    cost
    description
    id_card
    name
  }
}''';

String cardCategoryView = r'''query cardCategoryView {
  card_category {
    id_card_category
    name
    number_of_visits
    start_date
    end_date
  }
}
''';

String clientView = r'''query clientView {
  client {
    id_client
    number_of_visits
    weight
    growth
    age_person
  }
}
''';

String clientCardView = r'''query clientCardView {
  client_card {
    id_client_card
    client_id
    card_id
  }
}
''';

String coachView = r'''query coachView {
  coach {
    id_coach
    specialization
    sporting_achievements
    work_experience
    coachs_second_name
    coachs_patronymic
    coachs_first_name
  }
}
''';

String dietView = r'''query dietView {
  diet {
    id_diet
    name
    duration
    diet_category_id
    user_id
  }
}
''';

String dietCategoryView = r'''query dietCategoryView {
  diet_category {
    id_diet_category
    name
  }
}''';

String dietEatingView = r'''query dietEatingView {
  diet_eating {
    id_diet_eating
    eating_id
    diet_id
  }
}''';

String dishView = r'''query dishView {
  dish {
    id_dish
    name
    kcal
    pfc_id
  }
}''';

String eatingView = r'''query eatingView {
  eating {
    id_eating
    name
    eating_time
  }
}''';

String eatingDishView = r'''query eatingDishView {
  eating_dish {
    id_eating_dish
    dish_id
    eating_id
  }
}
''';

String exerciseView = r'''query exerciseView {
  exercise {
    id_exercise
    name
    load_score
    description
    exercise_plan_id
    exercise_category_id
  }
}
''';

String exerciseCategoryView = r'''query exerciseCategoryView {
  exercise_category {
    id_exercise_category
    name
  }
}''';

String exercisePlanView = r'''query exercisePlanView {
  exercise_plan {
    id_exercise_plan
    name
    description
    rest_time
    number_of_approaches
    number_of_repetitions
  }
}
''';

String feedbackMessageView = r'''query feedbackMessageView {
  feedback_message {
    id_feedback_message
    message
  }
}
''';

String groupWorkoutView = r'''query groupWorkoutView {
  group_workout {
    id_group_workout
    name
    recommended_age
    load_score
    event_date
    start_time
    end_time
    description
    group_workout_category_id
    coach_id
    user_id
  }
}
''';

String groupWorkoutCategoryView = r'''query groupWorkoutCategoryView {
  group_workout_category {
    id_group_workout_category
    name
  }
}
''';

String newsView = r'''query newsView {
  news {
    id_news
    title
    content
    create_date
    news_category_id
  }
}
''';

String newsCategoryView = r'''query newsCategoryView {
  news_category {
    id_news_category
    name
  }
}
''';

String personWorkoutView = r'''query personWorkoutView {
  person_workout {
    id_person_workout
    name
    description
    client_id
  }
}
''';

String personWorkoutExercise = r'''query personWorkoutExercise {
  person_workout_exercise {
    id_person_workout_exercise
    person_workout_id
    exercise_id
  }
}
''';

String personalData = r'''query personalData {
  personal_data {
    id_personal_data
    first_name
    second_name
    patronymic
    mobile_number
  }
}
''';

String pfcView = r'''query pfcView {
  pfc {
    id_pfc
    proteins
    fats
    carbohydrates
  }
}
''';

String serviceView = r'''query serviceView {
  service {
    id_service
    name
    cost
    description
    service_category_id
    user_id
  }
}''';

String serviceCategoryView = r'''query serviceCategoryView {
  service_category {
    id_service_category
    name
  }
}
''';

String usersView = r'''query usersView {
  users {
    id
    role
  }
}''';

//

String getAllDietsData = r'''query getAllDietsData {
  diet {
    id_diet
    name
    duration
    diet_category {
      id_diet_category
      name
    }
    diet_eatings {
      id_diet_eating
      eating {
        id_eating
        name
        eating_time
        eating_dishes {
          id_eating_dish
          dish {
            id_dish
            name
            kcal
            pfc {
              id_pfc
              proteins
              fats
              carbohydrates
            }
          }
        }
      }
    }
  }
}
''';

String allNews = r'''query AllNews {
  news {
    id_news
    title
    content
    create_date
    news_category {
      id_news_category
      name
    }
  }
}''';

String newsSearch = r'''query newsSearch($_like: String = "") {
  news(where: {title: {_like: $_like}}) {
    id_news
    title
    content
    create_date
    news_category {
      id_news_category
      name
    }
  }
}''';

String allGroupWorkout = r'''query group_workoutView {
  group_workout {
    id_group_workout
    load_score
    name
    recommended_age
    start_time
    description
    event_date
    end_time
    group_workout_category {
      id_group_workout_category
      name
    }
    coach {
      id_coach
      specialization
      sporting_achievements
      work_experience
      coachs_second_name
      coachs_patronymic
      coachs_first_name
    }
  }
}
''';

String allService = r'''query allService {
  service {
    id_service
    name
    cost
    description
    service_category {
      id_service_category
      name
    }
  }
}
''';

String allPersonWorkout = r'''
  query allPersonWorkout {
  person_workout {
    id_person_workout
    name
    description
    client_id
    person_workout_exercises {
      id_person_workout_exercise
      person_workout_id
      exercise_id
      exercise {
        id_exercise
        name
        load_score
        description
        exercise_plan {
          id_exercise_plan
          name
          number_of_approaches
          number_of_repetitions
          rest_time
          description
        }
        exercise_category {
          id_exercise_category
          name
        }
      }
    }
  }
  
  }
''';

String dietHelp = r'''query MyQuery {
  diet {
    id_diet
    name
    duration
  }
}
''';
