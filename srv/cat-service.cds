using { core } from  '../db/data-model';


service CatalogService {
  entity Currencies   as projection on core.Currencies;
  entity States as projection on core.States;
}